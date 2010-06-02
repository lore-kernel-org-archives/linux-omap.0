From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 03:00:01 -0700
Message-ID: <AANLkTilLmAb2c9fQwuguzWtjcHfuTZvPUTbUx7vuwFI6@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1275471561.27810.30865.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Florian Mickler <florian@mickler.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

2010/6/2 Peter Zijlstra <peterz@infradead.org>:
> On Wed, 2010-06-02 at 01:54 -0700, Arve Hj=F8nnev=E5g wrote:
>> No I want you to stop confusing low power idle modes with suspend.
>
> I think it is you who is confused. For power management purposes susp=
end
> is nothing more but a deep idle state.

No, idle is transparent, suspend is not.

>
> (and please don't mention @#$@ up x86 ACPI again, Intel knows, they'r=
e
> fixing it, get over it already).
>

I don't think it is realistic to drop support for all existing hardware=
=2E

>> Unrelated to
>> Android, I also want to use opportunistic suspend on my desktop.
>
> So you're going to sprinkle this suspend blocker shite all over regul=
ar
> userspace?

I have said several times, that regular user-space will not need to be
modified to maintain their current behavior.

> Why not instead work on getting apps to behave properly and
> idle when there's nothing to do?
>
> After all, if you have the code to add suspend blockers into, you als=
o
> have the means to fix it being stupid in the first place.
>

Why would I add suspend blockers to the code I want to prevent running?

--=20
Arve Hj=F8nnev=E5g
