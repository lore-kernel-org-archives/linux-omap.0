From: Shreyas Mahajan <mahajan.shreyas@gmail.com>
Subject: Re: Omap3430 does not resume after suspend
Date: Wed, 4 Feb 2009 12:00:04 +0530
Message-ID: <d105d8d00902032230w2a5ff7a3yd3511002cbcc9850@mail.gmail.com>
References: <d105d8d00901300124i60025abete9f0b0e86d676f82@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301C7069769@dbde02.ent.ti.com>
	 <d105d8d00902022214r4f67ecdcp4ce153f0c88cb512@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301C70FEB63@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:8467 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbZBDGaG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 01:30:06 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1177498wah.21
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2009 22:30:04 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301C70FEB63@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, linux-omap@vger.kernel.org

 Hi,
    Thanks for constantly tolerating my ignorance. I git-cloned the
latest PM tree available and booted my 3430 LDP board with ldp
defconfig configuration. Now the problem regarding hanging of machine
after some small interval is solved but when I done 'echo mem
>/sys/power/state' it gives error to suspend,
This is log for it,

'/ # echo mem > /sys/power/state
<6>PM: Syncing filesystems ... PM: Syncing filesystems ... done.
done.
=46reezing user space processes ... Freezing user space processes ...
(elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
done.
=46reezing remaining freezable tasks ... Freezing remaining freezable
tasks ... (elapsed 0=EF=BF=BD=02)=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr$=
=EF=BF=BDPowerdomain (core_pwrdm) d1
Powerdomain (per_pwrdm) didn't enter target state 1
             =EF=BF=BD*43
Could not enter target state in pm_suspendend to debug)
=EF=BF=BD=021=EF=BF=BD=D5=BC=EF=BF=BD=EF=BF=BD=EF=BF=BD,=02=E6=A3=AE=EF=
=BF=BD=D1=A0r=EF=BF=BD=EF=BF=BD
Restarting tasks ... Restarting tasks ... done.%=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD J$=EF=BF=BD4%=EF=BF=BD=
%=06=D1=B4=EF=BF=BD*43
done.F=EF=BF=BD=F3=B0=AF=85)=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD J$=EF=BF=
=BD4%=EF=BF=BD%=06=D1=B4=EF=BF=BD*43
'
I searched similar problems on mailing list, in which suspend log
contains exactly which process could not be stopped as reason to
suspend failure. But in above log, I could not interpret such a
reason.
         Could anyone please help me with this?

On Tue, Feb 3, 2009 at 3:02 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: Shreyas Mahajan [mailto:mahajan.shreyas@gmail.com]
>> Sent: Tuesday, February 03, 2009 11:44 AM
>> To: Premi, Sanjeev; linux-omap@vger.kernel.org
>> Subject: Re: Omap3430 does not resume after suspend
>>
>> On Fri, Jan 30, 2009 at 7:32 PM, Premi, Sanjeev <premi@ti.com> wrote=
:
>> >
>> > > -----Original Message-----
>> > > From: linux-omap-owner@vger.kernel.org
>> > > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Shreyas
>> > > Mahajan
>> > > Sent: Friday, January 30, 2009 2:54 PM
>> > > To: linux-omap@vger.kernel.org
>> > > Subject: Omap3430 does not resume after suspend
>> > >
>> > > Hello,
>> > >          I am a newbie with omap3430. As a part of my project, I
>> > > suspended my board with 'echo mem > /sys/power/state'.The suspen=
d
>> > > happens correctly, without giving any failure message.
>> But, when I
>> > > tried it to resume, it is not resuming.I tried to find
>> some reasons
>> > > for this, and got the patches for unmasking keyboard
>> interrupt while
>> > > suspending. But, all patches are for omap2 and omap1 board
>> > > architecture.
>> > [sp] Are you following updates in Kevin Hilman's pm branch?
>> > With lastest updates you shouldn't see this problem on a
>> minimal config.
>> >
>> > Would be good to start from here and add drivers selectively.
>> >
>> > > Are there any patches to do this thing in omap3430?
>> >
>> > [sp] omap2 applies to OMAP3430 as well.
>> >
>> > >
>> > > Thanks,
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe
>> > > linux-omap" in the body of a message to majordomo@vger.kernel.or=
g
>> > > More majordomo info at http://vger.kernel.org/majordomo-info.htm=
l
>> > >
>> > >
>>
>> Thanks for reply.
>> I went through the Kevin Hilman's PM branch and found the
>> same problem posted by you (@Sanjeev),
>>
>> 'Hangs on a echo mem > /sys/power/state
>> > Goes into suspend, but cannot recover'
>>
>> So, can you please tell me if this problem is solved?
>>
>
> [sp] Have not been able to follow-up in the latest tree for last coup=
le of days, but with minimal driver configuration; this problem is solv=
ed. I am in process of finding the 'offending' driver.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
