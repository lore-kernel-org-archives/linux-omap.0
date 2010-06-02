From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 02 Jun 2010 12:21:28 +0200
Message-ID: <1275474088.27810.31000.camel@twins>
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
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Florian Mickler <florian@mickler.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-06-02 at 03:00 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> 2010/6/2 Peter Zijlstra <peterz@infradead.org>:
> > On Wed, 2010-06-02 at 01:54 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> >> No I want you to stop confusing low power idle modes with suspend.
> >
> > I think it is you who is confused. For power management purposes su=
spend
> > is nothing more but a deep idle state.
>=20
> No, idle is transparent, suspend is not.

Which is where the problem is, it should be.

> Why would I add suspend blockers to the code I want to prevent runnin=
g?

Because what you want might not be what others want. Suppose you're fin=
e
with your torrent client/irc client/etc.. to loose their network
connection when you're not behind your desktop so you don't add suspend
blockers there.

Me, I'd be ready to administer physical violence if either of those los=
t
their connections when I wasn't around to keep the screen-saver from
kicking in.

This leads to having to sprinkle magic dust (and lots of config options=
)
all over userspace. Something that gets esp interesting with only a
boolean interface.

In the example above, having an active net connection would prevent my
desktop from suspending, but what if another platform can maintain net
connections while suspended? Do we then end up with arch specific code
in the net-stack? I'm sure DaveM would love that.
