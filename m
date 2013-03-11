From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/8] memory: emif: handle overflow for timing for LP mode
Date: Mon, 11 Mar 2013 11:05:50 +0530
Message-ID: <513D6D36.7060909@ti.com>
References: <1362978365-5593-1-git-send-email-lokeshvutla@ti.com> <1362978365-5593-4-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362978365-5593-4-git-send-email-lokeshvutla@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Monday 11 March 2013 10:36 AM, Lokesh Vutla wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> In case the custom timings provide values which overflow
> the maximum possible field value, warn and use maximum
> permissible value.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
