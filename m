From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] iommu: fix end address of vm area comparation in alloc_iovm_area
Date: Sun, 10 Oct 2010 19:38:25 +0300
Message-ID: <AANLkTi=ohFYHTgbUNP3cZ5npAFP-toUwSWk3stvg4uYR@mail.gmail.com>
References: <1282064161-21056-1-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1282064161-21056-1-git-send-email-x0095840@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Guzman Lugo <x0095840@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Hiroshi.DOYU@nokia.com, h-kanigeri2@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 17, 2010 at 7:56 PM, Fernando Guzman Lugo <x0095840@ti.com> wrote:
> End address of the vm area is .start + bytes -1., not start + byte.
> This patch fixes that issue by doing an inclusive comparison with
> tmp->da_start. This issue was preventing allocate an area of size
> exactly the same than the free area. I did no change the value of
> da_end of each vm area because it is used to get area size in
> several places.
>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
