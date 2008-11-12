From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3 powerdomains: remove RET from SGX power states
 list
Date: Wed, 12 Nov 2008 12:07:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811121157530.28853@utopia.booyaka.com>
References: <alpine.DEB.2.00.0811051152150.15612@utopia.booyaka.com> <20081106033327.GQ21736@atomide.com> <alpine.DEB.2.00.0811060401150.11718@utopia.booyaka.com> <87ej1na8c2.fsf@trdhcp146196.ntc.nokia.com> <alpine.DEB.2.00.0811100741420.23090@utopia.booyaka.com>
 <87r65i66j5.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1247109330-1226516352=:28853"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60707 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbYKLTHK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 14:07:10 -0500
In-Reply-To: <87r65i66j5.fsf@trdhcp146196.ntc.nokia.com>
Content-ID: <alpine.DEB.2.00.0811121201080.28853@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "Stoppa Igor \\\\\\(Nokia-D/Helsinki\\\\\\)" <Igor.Stoppa@nokia.com>, r-woodruff2@ti.com, Kevin Hilman <khilman@deeprootsystems.com>, "Sawant, Anand" <sawant@ti.com>, Poussa Sakari <sakari.poussa@nokia.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1247109330-1226516352=:28853
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.0811121201081.28853@utopia.booyaka.com>

Hi Jouni, Kevin,

On Tue, 11 Nov 2008, H=F6gander Jouni wrote:

> I wouldn't add any flags for this. The goal is finally to set all
> next_states as OFF until someone has set some constraint which
> prevents OFF usage. For now we need to use RET as default, because
> drivers are not supporting OFF mode. Do you agree this?

Yes.

> Easiest way here would be to add own hook for SGX in pwrdms_setup? One=20
> more strcmp("*_pwrdm, pwrdm->name) :)
>=20
> What do you think?

That is okay with me.  This seems to be an unusual case - I guess it's due=
=20
to an SGX firmware bug. =20

So Kevin, if you have a strong opposition to that strcmp, maybe we should=
=20
use a powerdomain flag for the SGX pwrdm.  Otherwise, let's go with a=20
strcmp as Jouni suggested.  Thoughts?


- Paul
--155748971-1247109330-1226516352=:28853--
