From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] OMAP4: pcrm: Fix errors in few defines name
Date: Thu, 30 Jun 2011 17:02:31 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106301646410.2874@utopia.booyaka.com>
References: <1308847544-2322-1-git-send-email-b-cousson@ti.com> <1308847544-2322-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1054549009-1309474951=:2874"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39240 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab1F3XCc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 19:02:32 -0400
In-Reply-To: <1308847544-2322-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1054549009-1309474951=:2874
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

just FYI the subject of this message should read "prcm" rather than "pcrm"

On Thu, 23 Jun 2011, Benoit Cousson wrote:

> A couple of macros were wrongly changed during the _MOD to _INST
> rename done in the following commit:
>=20
>   OMAP4: PRCM: rename _MOD macros to _INST
>   cdb54c4457d68994da7c2e16907adfbfc130060d
>=20
> Fix them to their original name.
>=20
> Some CM and PRM instances were not well aligned. Align them.
>=20
> Remove one blank line in cm2_44xx.h to align the output with
> the other (cm1_44xx.h, prm44xx.h) files.
>=20
> Replace one tab with space.
>=20
> Update header copyright date.
>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Thanks Beno=EEt, this one was my fault.

Reviewed-by: Paul Walmsley <paul@pwsan.com>


- Paul
--155748971-1054549009-1309474951=:2874--
