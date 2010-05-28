From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 09:43:43 +0200
Message-ID: <1275032623.32462.30.camel@laptop>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	 <20100527181433.GG3543@srcf.ucam.org>
	 <20100527200313.5c532f2f@lxorguk.ukuu.org.uk>
	 <201005280110.17075.rjw@sisk.pl>
	 <20100528005045.6ea5feba@lxorguk.ukuu.org.uk>
	 <AANLkTimqvMuMpB5E3tj58OtlRc-7mVaec-9EHAegywg7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimqvMuMpB5E3tj58OtlRc-7mVaec-9EHAegywg7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-05-27 at 17:45 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> What happens if the user presses the button right before you set QoS
> of 'user apps' to  QS_NONE?
> To me it looks like this solution would result in this sequence which
> may ignore the button press:
>         Button pushed
>         Button driver sets QoS of app it wakes to QS_ABOVESUSPEND
>         Set QoS of 'user apps' to QS_NONE=20

I don't think we should change app QoS parameters, but change service
provider parameters.

=46or instance, suppose the filesystem-IO QoS has 3 levels:=20
  High, Normal and Idle.

Then if we assign Idle to updatedb, we'll service it as long as the
filesystem-server QoS has a higher level (High and Normal). When we
change the filesystem-serves' QoS to idle, it finds there is nothing to
keep it servicing stuff and it'll block pending requests, updatedb stop=
s
being runnable and we're good.
