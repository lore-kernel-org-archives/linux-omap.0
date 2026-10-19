Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85F947F2D1;
	Mon, 19 Oct 2026 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392378; cv=none; b=lYlZUhrUpYzvMGD3zK70OT1JtyfT4SBXdqXOdl3JRR9CprX69r6OSjzohmV9tvvsDJ0dco7JBgcFo4JRmOTMNg2jH3jkIXWcwm5L6XA/Yk2cOU6SeeLIyZVUENzx4qpIz5nb96u+ViEXTovtvN/ZEReGmKcvawIvkiOUxo/m+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392378; c=relaxed/simple;
	bh=YQ8lTf8izlpocVzFGJ3tCmF9xA0j178kX/fbHROKyeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebXvygT+BWGmwGDn15RJAwfCa0BSS0LD1+PnCT79CkvJ8F+HS9Us2VPlddxCuxv3zPMQ5hGt9gI3ZZGvWi8bU0uUMo+Xh0hKLWPuxVfTbJZwgH4Y28aMCw3WUW9imBmnEAjuzWZ3alUciqzm3HqxzQss8d8ilmNwbhIZ4H2uNoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KQ/zhJaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KQ/zhJaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8280A1F000C4;
	Mon, 19 Oct 2026 06:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792392376;
	bh=UibeRcsOWMwjU2MgWXLgP4E0ubSKnMg/pKDOUT5jzAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KQ/zhJafUctp/xenhL6xzsSzTcWU+zX5TcuMZq2ApWU1+W3bzWaHwtzMlUZJvlRSt
	 gHLbjjmmeBHkUJ7vTcjor3sgmga8lDa2kuhe996IekmInvmZWZBNBxli1XTBLJsI6/
	 KwIhyvcyMeRueM+4fDHM6uC1rgnr5INoBhGxpBCs=
Date: Mon, 19 Oct 2026 08:46:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] usb: ohci-omap: implement overcurrent handling for
 GPIO-based power control
Message-ID: <2026101934-ferris-seldom-69d2@gregkh>
References: <20261018223312.120913-1-ampr.mhd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261018223312.120913-1-ampr.mhd@gmail.com>

On Mon, Oct 19, 2026 at 02:03:12AM +0330, Muhammad Mahdi Amirpour wrote:
> The OMAP OHCI driver has had optional GPIO lines for VBUS power control
> and overcurrent detection since the gpiolib conversion, but the
> overcurrent line was never wired up — it was marked with a TODO comment.
> 
> On boards like the OMAP1 OSK, the VBUS power switch (TPS2045) is
> controlled via a TPS65010 GPIO, and overcurrent is reported on a
> separate GPIO. Without this patch, an overcurrent condition is not
> detected by software and VBUS power is not cut, relying solely on the
> hardware current limiter.
> 
> This patch implements the missing overcurrent handling:
> - Requests a threaded IRQ on the overcurrent GPIO (both edges)
> - Cuts VBUS power via the power GPIO when overcurrent is detected
> - Reports overcurrent status and change through the root hub port
>   status callbacks so the USB hub core can react
> - Handles SetPortFeature/ClearPortFeature(POWER) to drive the VBUS
>   GPIO alongside the OHCI hardware register
> - Turns off VBUS on driver removal and probe failure
> 
> Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
> ---
> v4:
>   - Remove spinlock entirely; use READ_ONCE/WRITE_ONCE for the
>     overcurrent flags (Greg KH).  This also fixes the bug where
>     gpiod_set_value_cansleep() was called under spin_lock_irqsave(),
>     which sleeps on the I2C-attached TPS65010 (Sashiko).

Are you sure this is correct?  You never responded to my previous review
comments here, just submitted a new version which is a bit odd...

thanks,

greg k-h
