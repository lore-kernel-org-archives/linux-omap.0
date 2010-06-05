From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 5 Jun 2010 20:44:24 +0300
Message-ID: <AANLkTikna-Vs_phy2VrJs0I8gIsdSmwuxTJ67gQ_2oTt@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005302202.39511.rjw@sisk.pl>
	<AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
	<201005312347.24251.rjw@sisk.pl>
	<AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
	<alpine.LFD.2.00.1006011411200.2933@localhost.localdomain>
	<AANLkTikZHmF6baP7dEXEGFE8YsbEteRjlhb5wqZX8ll1@mail.gmail.com>
	<alpine.LFD.2.00.1006020905410.2933@localhost.localdomain>
	<AANLkTinDm3FIrbS1jqEzW15THmr1hdd7ox0Mllm1VLjZ@mail.gmail.com>
	<1275471561.27810.30865.camel@twins>
	<AANLkTilLmAb2c9fQwuguzWtjcHfuTZvPUTbUx7vuwFI6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTilLmAb2c9fQwuguzWtjcHfuTZvPUTbUx7vuwFI6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Florian Mickler <florian@mickler.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

2010/6/2 Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>:
> 2010/6/2 Peter Zijlstra <peterz@infradead.org>:
>> (and please don't mention @#$@ up x86 ACPI again, Intel knows, they'=
re
>> fixing it, get over it already).
>>
>
> I don't think it is realistic to drop support for all existing hardwa=
re.

We are talking about mainline here, there's no support for suspend
blockers, so nothing is dropped.

In the mind of everybody, suspend blockers is for opportunistic
suspend, which only makes sense on sensible hw (not current x86). So
in the mind of everybody, x86 should be out of scope for the analysis
of suspend blockers.

Are you seriously suggesting that one of the strong arguments in favor
of suspend blockers is x86 usage (nobody agrees)? If not, then drop
it.

>>> Unrelated to
>>> Android, I also want to use opportunistic suspend on my desktop.
>>
>> So you're going to sprinkle this suspend blocker shite all over regu=
lar
>> userspace?
>
> I have said several times, that regular user-space will not need to b=
e
> modified to maintain their current behavior.

If I enable suspend blockers on my laptop, I have to modify my
user-space. Otherwise my system will behave horribly.

--=20
=46elipe Contreras
