From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [RFC v2]: Issues implementing clock handling mechanism within
 UART driver
Date: Mon, 1 Aug 2011 18:16:59 +0530
Message-ID: <CAAL8m4xTiwH4dKYMWm1M=xMSEzZD=hgL_dxUZeSBkda_58VF7g@mail.gmail.com>
References: <20110729095512.GE31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4xjN15RfwbDd_c1HdoKY327CWOn5qwuoUT=fop4J0K5cw@mail.gmail.com>
 <20110729113713.GK31013@legolas.emea.dhcp.ti.com> <CAAL8m4wq7RQ_Rp-+LMWYY=dtTnhtR5UY+8HpO5C_54goKezaTg@mail.gmail.com>
 <20110729121907.GM31013@legolas.emea.dhcp.ti.com> <CAAL8m4wQqS64xG0Vi9YCOdy3f2=1V7UkJCErpikHOra4X=g7+w@mail.gmail.com>
 <20110729140210.GT31013@legolas.emea.dhcp.ti.com> <CAAL8m4wdKu_XGFaGxuAJ9uypRyyQMkR8HL7Y6E=pBkwX=L43nA@mail.gmail.com>
 <20110801090328.GG31013@legolas.emea.dhcp.ti.com> <CAMrsUdL_9mzKsjrKf=spihxcRTQc6Tsr+MAP9GFAz_7sE27B6Q@mail.gmail.com>
 <20110801100203.GN31013@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20110801100203.GN31013@legolas.emea.dhcp.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: balbi@ti.com
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 1, 2011 at 3:32 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> (fix your mailer dude)

Sorry some settings got screwed up with my mailer

>
> On Mon, Aug 01, 2011 at 03:26:52PM +0530, Raja, Govindraj wrote:

[..]

>> =C2=A0 =C2=A0 =C2=A0this hunk is unnecessary. Clocks are always on w=
hen they are called.
>>
>> =C2=A0 =C2=A0The problem is:
>> =C2=A0 =C2=A0[1]:
>> =C2=A0 =C2=A0runtime_put -> *power.lock* - > rpm->suspend -> above p=
r_debug ->
>> =C2=A0 =C2=A0console_write -> get_sync
>> =C2=A0 =C2=A0-> *power.lock* -> rpm resume
>> =C2=A0 =C2=A0power.lock contention.
>
> Are you sure ? If the device is still on, won't that get_sync() only
> increase the pm counter ? Instead of going through everything ?? Oh
> well, this is becoming quite racy :-(

Yes true, but before it increments the counter it will take
power.lock

if we look into internals.

pm_runtime_get_sync -> *__pm_runtime_resume* --> rpm_resume

int __pm_runtime_resume(struct device *dev, int rpmflags)
{
 [..]
        spin_lock_irqsave(&dev->power.lock, flags);
        retval =3D rpm_resume(dev, rpmflags);
        spin_unlock_irqrestore(&dev->power.lock, flags);
[..]
}

Same applicable for runtime_put

[..]
>> =C2=A0 =C2=A0 =C2=A0I'll leave this to Kevin to decide what to do, b=
ut clocks are off
>> =C2=A0 =C2=A0 =C2=A0here...
>>
>> =C2=A0 =C2=A0Yes fine.=EF=BF=BD
>> =C2=A0 =C2=A0Since most of these prints will be printed if DEBUG mac=
ro
>> =C2=A0 =C2=A0is defined in respective files and *debug* is used in c=
ommand line.
>> =C2=A0 =C2=A0Can't leave uart clocks active always on debug cases.
>> =C2=A0 =C2=A0[If *debug* =EF=BF=BDused as command line]
>> =C2=A0 =C2=A0and gate uart clocks only for non debug cases.
>> =C2=A0 =C2=A0With this approach=EF=BF=BDat least=EF=BF=BDwe can have=
 a clean solution
>> =C2=A0 =C2=A0in uart driver also without adding clock gating from id=
le path.
>> =C2=A0 =C2=A0Not sure if this=EF=BF=BDagreeable.
>> =C2=A0 =C2=A0As of now gating from idle path seems to be only clean =
approach.
>
> I see.. that could be one way... let's see how Kevin feels about it
> though.
>

OK.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
