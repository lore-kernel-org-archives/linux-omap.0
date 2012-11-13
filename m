From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] usb: otg: twl4030: Change TWL4030_MODULE_* ids to TWL_MODULE_*
Date: Tue, 13 Nov 2012 11:57:13 +0100
Message-ID: <50A22789.7070103@ti.com>
References: <1352799818-22363-1-git-send-email-peter.ujfalusi@ti.com> <20121113094722.GB10395@arwen.pp.htv.fi> <50A220BF.7020901@ti.com> <20121113103757.GE10951@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121113103757.GE10951@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

On 11/13/2012 11:37 AM, Felipe Balbi wrote:
> ok good. Unfortunately I have already sent this merge window's pull
> request to Greg so I'd have to delay this until v3.9. If that's ok wi=
th
> you, I can take it through my tree.

I hoped that this can go with 3.8 since in 3.9 I'm planning to remove a=
ll of
these TWL4030_MODULE_* defines which have TWL_MODULE_* counterpart.
In this case I will introduce dummy defines to point to the correct pla=
ce for
the USB in 3.9 and we can get rid of the rest of these in 3.10. Oh well=
=2E This
is going to take a bit longer than I have anticipated.
I can't think of any other subsytem this can go through...

--=20
P=E9ter
