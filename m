From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC][PATCH] OMAP3: add support for 2 SDRAM chip selects (was:
 Re: Beagleboard rev C memory timings & suspend/resume)
Date: Fri, 5 Jun 2009 13:14:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906051308370.31531@utopia.booyaka.com>
References: <200904291553.49378.jpihet@mvista.com> <200905261527.16648.jpihet@mvista.com> <alpine.DEB.2.00.0906021724490.31531@utopia.booyaka.com> <200906051735.57772.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-634465754-1244229147=:31531"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35765 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZFETOr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 15:14:47 -0400
In-Reply-To: <200906051735.57772.jpihet@mvista.com>
Content-ID: <alpine.DEB.2.00.0906051312490.31531@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, notasas@gmail.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-634465754-1244229147=:31531
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.0906051312491.31531@utopia.booyaka.com>

Hi Jean,

On Fri, 5 Jun 2009, Jean Pihet wrote:

> Some notes:
> - all calls to omap2_init_common_hw have been adapted in the board files.=
 it=20
> looks like 2430SDP and Pandora board files are broken since they use only=
 one=20
> param. Can that be checked on those boards?

Yep, builds with those two boards are broken on the PM branch, and it=20
looks like your patch fixes both. =20

Gra=B8yvdas, looks like Pandora might use 2 SDRAM chipselects also?


- Paul
--155748971-634465754-1244229147=:31531--
