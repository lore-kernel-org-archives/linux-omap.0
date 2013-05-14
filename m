From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ARM : omap : remove __init for _enable_preprogram
Date: Tue, 14 May 2013 14:26:26 -0400
Message-ID: <20130514182626.GC32651@kroah.com>
References: <1368547621-8570-1-git-send-email-jp.francois@cynove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:35306 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416Ab3ENS0P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 May 2013 14:26:15 -0400
Received: by mail-vc0-f177.google.com with SMTP id ha12so946340vcb.36
        for <linux-omap@vger.kernel.org>; Tue, 14 May 2013 11:26:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1368547621-8570-1-git-send-email-jp.francois@cynove.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jp.francois@cynove.com
Cc: khilman@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, paul@pwsan.com, stable@vger.kernel.org

On Tue, May 14, 2013 at 06:07:01PM +0200, jp.francois@cynove.com wrote:
> _enable_preprogram is marked as __init, but is called from _enable wh=
ich is not.
> This results in oops once init is freed.
> Fix this by removing the __init marker.
>=20
> Signed-off-by: Jean-Philippe Fran=E7ois <jp.francois@cynove.com>

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
