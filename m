From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v3 1/4] MFD: Palmas: Check if irq is valid
Date: Wed, 19 Jun 2013 11:08:53 -0600
Message-ID: <51C1E5A5.9090105@wwwdotorg.org>
References: <1371621470-22279-1-git-send-email-j-keerthy@ti.com> <1371621470-22279-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1371621470-22279-2-git-send-email-j-keerthy@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, ldewangan@nvidia.com, sameo@linux.intel.com, grant.likely@secretlab.ca, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, gg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On 06/18/2013 11:57 PM, Keerthy wrote:
> From: J Keerthy <j-keerthy@ti.com>
> 
> Check if irq value obtained is valid. If it is not valid
> then skip the irq request step and go ahead with the probe.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
