From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v8 19/20] OMAP2+: UART: Do not gate uart clocks if used
 for debug_prints
Date: Tue, 3 Jan 2012 19:42:46 +0530
Message-ID: <CAAL8m4z-AsVzfubqBy=nP6EN=m6MjTma1+50+aywQ=hmoF6Ejg@mail.gmail.com>
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
 <1321005712-21871-5-git-send-email-govindraj.raja@ti.com> <B5906170F1614E41A8A28DE3B8D1214304B3E2@DBDE01.ent.ti.com>
 <CAAL8m4yXD-gpeXNVsCOYeDkYDWmVX8FUcpXKjx6k=AXSF4V9iA@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D1214304BAD3@DBDE01.ent.ti.com>
 <CAAL8m4yhtUNjoKwECnQEYNoaL-M+RaHXACanAeJW64DPsJ_hWg@mail.gmail.com> <B5906170F1614E41A8A28DE3B8D1214304BB42@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <B5906170F1614E41A8A28DE3B8D1214304BB42@DBDE01.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "R, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 3, 2012 at 5:22 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> w=
rote:
> On Tue, Jan 03, 2012 at 16:01:52, Govindraj wrote:
>> >
>> > I have basic suspend-resume working on it. Strangely this works ir=
respective
>> > of the value of tty_dev wakeup entry. Do you know if this is expec=
ted on OMAP?
>> >
>>
>> AFAIK yes.
>
> Ok.
>
>>
>> > The other issue concerning runtime PM is that as soon as I set a n=
on-zero to
>> > the autosuspend_delay_ms I get some garbage characters and eventua=
lly the
>> > console stops responding.
>> >
>> > [root@arago /]# cat .../omap_uart.0/power/autosuspend_delay_ms
>> > -1
>> > [root@arago /]# echo 3000 > =D6KW=EB=E9=AB+=D7=E9=AB+wU.=C9=D1=B9,=
z,=BD=DD.=C9=BDosuspend_delay=D5=A3=BD=CD=D5=CD...
>> > [root@arago /]# <- No response after some time
>> >
>>
>> try enabling CONFIG_CPU_IDLE for pm qos_usage from uart driver.
>>
>
> Its enabled.

I checked on Beagle-xm with latest LO master I don't see that issue.

Lo master commit used
commit: 6489f6de3a219dfd23a91261eea1b09fba7ae128

Logs:
http://pastebin.pandaboard.org/index.php/view/55509914

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
