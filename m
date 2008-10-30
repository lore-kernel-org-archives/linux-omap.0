From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 01/21] ARM: OMAP: Clean-up OMAP GPIO request/free functions
Date: Thu, 30 Oct 2008 09:55:02 -0700
Message-ID: <200810300955.03111.david-b@pacbell.net>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com> <200810291049.50101.david-b@pacbell.net> <20081030145835.5d1e6f08.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:39095 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753649AbYJ3QzF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2008 12:55:05 -0400
In-Reply-To: <20081030145835.5d1e6f08.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Thursday 30 October 2008, Jarkko Nikula wrote:
>=20
> > At the end of this patch series, delete these. =A0:)
> >=20
> Probably these should exist over one release cycle so that out-kernel
> tree projects have time to convert their drivers? No big deal to me,
> but wanted to be kind :-)

The other GPIO changes don't keep such wrappers ... so it
wouldn't help that much.

There's a general policy for kernel API changes, and it's
to update mainline and let other code fend for itself.
It's a mild incentive for drivers to get into mainline.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
