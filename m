From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 8/8] memory: emif: Load the correct custom config values
 from dt
Date: Mon, 11 Mar 2013 11:21:30 +0530
Message-ID: <513D70E2.6030702@ti.com>
References: <1362978365-5593-1-git-send-email-lokeshvutla@ti.com> <1362978365-5593-9-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362978365-5593-9-git-send-email-lokeshvutla@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday 11 March 2013 10:36 AM, Lokesh Vutla wrote:
> of_get_property returns value in Big Endian format.
> Before using this value it should be converted to little endian
> using be32_to_cpup().
> Custom configs of emif are read from dt using of_get_property,
> but these are not converted to litte endian format.
> Correcting the same here.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
Looks fine.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
