From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/8] staging: tidspbridge - remove req_addr from proc_map
Date: Tue, 26 Oct 2010 14:46:14 +0300
Message-ID: <AANLkTimCDM_nruvh_gqxxy0CVnw2sH5UYNT9VgyeBfZN@mail.gmail.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<1288054306-4361-2-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1288054306-4361-2-git-send-email-x0095840@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Guzman Lugo <x0095840@ti.com>
Cc: gregkh@suse.de, felipe.contreras@nokia.com, Hiroshi.DOYU@nokia.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 26, 2010 at 3:51 AM, Fernando Guzman Lugo <x0095840@ti.com> wrote:
> The device address is assigned by tidspbridge no need for that parameter anymore.
>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>

This would break the API with user-space, right?

I think this change should be delayed, preferably after we have a
working tidspbridge.

-- 
Felipe Contreras
