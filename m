From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] 34XX: Fix to use correct shift values for gpio2-6
 fclks
Date: Wed, 26 Mar 2008 14:25:33 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0803261425030.19060@utopia.booyaka.com>
References: <1206532658-11875-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2089224148-1206563133=:19060"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42512 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbYCZUZf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Mar 2008 16:25:35 -0400
In-Reply-To: <1206532658-11875-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?Jouni_H=F6gander?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2089224148-1206563133=:19060
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 26 Mar 2008, Jouni H=F6gander wrote:

> Wrong shift values were used for gpio2-6  fclks (gpt2-6 shift).
> ---
>  arch/arm/mach-omap2/clock34xx.h |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Paul Walmsley <paul@pwsan.com>=20

thanks Jouni,

- Paul
--155748971-2089224148-1206563133=:19060--
