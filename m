From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 01/16] remoteproc: Extend rproc_da_to_va() API with a
 flags parameter
Date: Mon, 26 Nov 2018 15:29:16 -0600
Message-ID: <d93c4c96-e0b9-59cd-6098-92684bc2360b@lechnology.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543218769-5507-2-git-send-email-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/26/18 1:52 AM, Roger Quadros wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The rproc_da_to_va() API is currently used to perform any device
> to kernel address translations to meet the different needs of the
> remoteproc core/platform drivers (eg: loading). The function also
> invokes the da_to_va ops, if present, to allow the remoteproc
> platform drivers to provide address translation. However, not all
> platform implementations have linear address spaces, and may need
> an additional parameter to be able to perform proper translations.
> 
> The rproc_da_to_va() API and the rproc .da_to_va ops have therefore
> been expanded to take in an additional flags field enabling some
> remoteproc implementations (like the TI PRUSS remoteproc driver)
> to use these flags. Also, define some semantics for this flags
> argument as this can vary from one implementation to another. A
> new flags type is encoded into the upper 16 bits along side the
> actual value in the lower 16-bits for the flags argument, to
> allow different individual implementations to have better
> flexibility in interpreting the flags as per their needs.

This seems like an overly complex solution for a rather simple
problem. Instead of passing all sorts of flags, could we just add
a parameter named "page" to da_to_va() that indicates the memory
page of the address in the remote processor?

Or perhaps there is some other use for all of these flags that I
am not aware of?
