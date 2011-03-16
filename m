From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/13] omap: use list_move() instead of
 list_del()/list_add() combination
Date: Wed, 16 Mar 2011 17:13:49 +0530
Message-ID: <1300275829.1917.94.camel@lappyti>
References: <1300229605-14499-1-git-send-email-kirill@shutemov.name>
	 <1300229605-14499-6-git-send-email-kirill@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38645 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab1CPLoD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Mar 2011 07:44:03 -0400
In-Reply-To: <1300229605-14499-6-git-send-email-kirill@shutemov.name>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-15 at 17:53 -0500, Kirill A. Shutemov wrote:
> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> ---
>  drivers/video/omap/blizzard.c |    3 +--
>  drivers/video/omap/hwa742.c   |    3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


