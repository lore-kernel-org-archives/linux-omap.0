From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: tsc2007: do I2C transfers in non-interrupt
	context
Date: Mon, 11 May 2009 08:38:09 -0700
Message-ID: <20090511153808.GA6973@dtor-d630.eng.vmware.com>
References: <483a38b80905110444n7d55b967j70cf2639dff1c706@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:48975 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbZEKPiR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 11:38:17 -0400
Content-Disposition: inline
In-Reply-To: <483a38b80905110444n7d55b967j70cf2639dff1c706@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

On Mon, May 11, 2009 at 08:44:00PM +0900, Kwangwoo Lee wrote:
> From d5de0d22109de7564f9bf1df688acbe6b18f41db Mon Sep 17 00:00:00 2001
> From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
> Date: Mon, 11 May 2009 20:05:50 +0900
> Subject: [PATCH 2/2] Input: tsc2007: do I2C transfers in non-interrupt context.
> 
> This patch enhances pointer movements much smoother.
> The original patch is written by Thierry.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@gmail.com>
> ---
>  drivers/input/touchscreen/tsc2007.c |   18 ++++++++++++++----
>  1 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tsc2007.c
> b/drivers/input/touchscreen/tsc2007.c
> index 948e167..03bbe58 100644
> --- a/drivers/input/touchscreen/tsc2007.c
> +++ b/drivers/input/touchscreen/tsc2007.c
> @@ -70,6 +70,7 @@ struct ts_event {
>  struct tsc2007 {
>  	struct input_dev	*input;
>  	char			phys[32];
> +	struct work_struct	work;

Every time I see a work_struct in a driver and don't see
cancel_work_sync() anywhere I know there are issues...

-- 
Dmitry
