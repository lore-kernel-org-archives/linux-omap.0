From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] pci: Add quirk for setting valid class for TI816X
 Endpoint
Date: Tue, 12 Apr 2011 09:15:33 -0700
Message-ID: <20110412091533.224387a8@jbarnes-desktop>
References: <1301986970-16482-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1301986970-16482-1-git-send-email-hemantp@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue,  5 Apr 2011 12:32:50 +0530
Hemant Pedanekar <hemantp@ti.com> wrote:

> TI816X (common name for DM816x/C6A816x/AM389x family) devices configured to boot
> as PCIe Endpoint have class code = 0. This makes kernel PCI bus code to skip
> allocating BARs to these devices resulting into following type of error when
> trying to enable them:
> 
> "Device 0000:01:00.0 not available because of resource collisions"
> 
> The device cannot be operated because of the above issue.
> 
> This patch adds a ID specific (TI VENDOR ID and 816X DEVICE ID based) 'early'
> fixup quirk to replace class code with PCI_CLASS_MULTIMEDIA_VIDEO as class.
> 
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
> ---

Applied to my linux-next branch, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
