From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] Input: ads7846: add regulator support
Date: Sat, 13 Feb 2010 19:52:10 +0000
Message-ID: <20100213195210.GA405@opensource.wolfsonmicro.com>
References: <1266078714-18155-1-git-send-email-notasas@gmail.com> <f870da181002131140q45c91251mdd19f51bf5c9c9d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58714 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752727Ab0BMTwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 13 Feb 2010 14:52:12 -0500
Content-Disposition: inline
In-Reply-To: <f870da181002131140q45c91251mdd19f51bf5c9c9d7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike.rapoport@gmail.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org

On Sat, Feb 13, 2010 at 09:40:26PM +0200, Mike Rapoport wrote:
> On Sat, Feb 13, 2010 at 6:31 PM, Grazvydas Ignotas <notasas@gmail.com=
> wrote:

> > + =A0 =A0 =A0 ts->reg =3D regulator_get(&spi->dev, "vcc");

> "vcc" is way too generic name. What about "vcc-ts" or "vcc-touch"?

This should be OK as-is - the general style for regulators is to use
whatever the name the datasheet gives to the supply.  The string used
is namespaced using the supplied struct device and isn't connected to
the strings used to name the regulator providing the supply so there
should be no cause for name collisions.

Only supplies for things like CPUs which don't currently have struct
devices associated with them have issues with name collisions.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
