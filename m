From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RESEND] usb: musb: omap: fix crash when musb glue (omap)
 gets initialized
Date: Fri, 23 Mar 2012 03:59:32 +0530
Message-ID: <CAAe_U6J8hpGWAZPnfYOWuM=mVxW84cs=ajhdedBKx+pLXOSyhw@mail.gmail.com>
References: <1332412545-32396-1-git-send-email-kishon@ti.com>
	<20120322143351.GB19835@kroah.com>
	<CAAe_U6JwPbzgn2M+J20rZvoDdmOuS_YOxVitDWPM_wyJmdbcdg@mail.gmail.com>
	<20120322213918.GA11352@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120322213918.GA11352-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Greg,

On Fri, Mar 23, 2012 at 3:09 AM, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> w=
rote:
> On Fri, Mar 23, 2012 at 03:04:04AM +0530, ABRAHAM, KISHON VIJAY wrote=
:
>> Hi Greg,
>>
>> On Thu, Mar 22, 2012 at 8:03 PM, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org=
> wrote:
>> > On Thu, Mar 22, 2012 at 04:05:45PM +0530, Kishon Vijay Abraham I w=
rote:
>> >> Upstream Commit: 7acc6197b76edd0b932a7cbcc6cfad0a8a87f026
>> >> Upstream Kernel Tag: v2.6.38-rc5-94-g7acc619
>> >
>> > <snip>
>> >
>> > <formletter>
>> >
>> > This is not the correct way to submit patches for inclusion in the
>> > stable kernel tree. =A0Please read Documentation/stable_kernel_rul=
es.txt
>> > for how to do this properly.
>> >
>> > </formletter>
>>
>> I really couldn't get what I'm missing after reading the
>> Documentation/stable_kernel_rules.txt :-( Can you kindly let me know
>> what I'm missing here?
>
> Read the version of that file in the 3.3 kernel release, it should
> explain what you are forgetting (hint, do you really want it applied =
to
> the 2.4 kernel tree?)

I actually intended this patch to be back-ported to previous releases
which will have the issue. I'm not sure if it is right?

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
