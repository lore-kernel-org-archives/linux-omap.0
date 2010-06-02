From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 1 Jun 2010 20:15:17 -0700
Message-ID: <AANLkTinsgmHh7iLhESPXiTkoW9SL4H8E92-7bARpDxNX@mail.gmail.com>
References: <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100601135102.GA8098@srcf.ucam.org>
	<1275426085.21962.967.camel@mulgrave.site>
	<201006020024.14220.rjw@sisk.pl>
	<1275431816.21962.1108.camel@mulgrave.site>
	<AANLkTikObnAZbyOxeYAhXcEbimO3XTTO-HlC9CD_HH6t@mail.gmail.com>
	<CA1BBBBC9359F04AA639128AC0D5D1E9692AAF29@orsmsx502.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA1BBBBC9359F04AA639128AC0D5D1E9692AAF29@orsmsx502.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gross, Mark" <mark.gross@intel.com>
Cc: James Bottomley <James.Bottomley@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, "tytso@mit.edu" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Stern <stern@rowland.harvard.edu>, Neil Brown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org

2010/6/1 Gross, Mark <mark.gross@intel.com>:
=2E..
>>4. It would be useful to change pm_qos_add_request to not allocate
>>anything so can add constraints from init functions that currently
>>cannot fail.
> [mtg: ] I'm not sure how to do this but I agree it would be good. =A0=
I guess we could have a block of pm_qos requests pre-allocated statical=
ly and re-use them. =A0In practice there will not be more than a handfu=
l of requests ever. =A0Dynamic allocation does seem like a bit of a was=
te.

The calling code will have to store a pointer to your structure
anyway, you may as well have them provide the whole structure.

--=20
Arve Hj=F8nnev=E5g
