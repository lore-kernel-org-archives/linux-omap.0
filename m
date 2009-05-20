From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: OpenGL flicker issue in Android
Date: Wed, 20 May 2009 15:27:36 +0300
Message-ID: <1242822456.16944.1.camel@tubuntu>
References: <221265CC-5630-45D1-8046-08E6AE3B9F79@mac.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53993 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346AbZETM3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 08:29:22 -0400
In-Reply-To: <221265CC-5630-45D1-8046-08E6AE3B9F79@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

On Wed, 2009-05-20 at 14:16 +0200, ext Elvis Dowson wrote:
> Hi Tomi,
>             Would you be able to shed some light on the OpenGL flicker
> issue when using Android with TI OMAP 3503 or 3530 hardware? 
> 
> 
> 
> I can see transient background image artifacts when working with the
> widgets, and some say that this maybe a bug in the framebuffer
> driver? 
> 
> 
> OpenGL composition artefacts - android-porting | Google Groups
> 

Are you using DSS2 driver? But sounds like a double buffering issue in
the application to me. How do you do double buffering?

 Tomi


