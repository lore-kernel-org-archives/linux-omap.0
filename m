From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 17/17] ARM: dts: am335x-*: Enable PRU-ICSS nodes
Date: Mon, 26 Nov 2018 10:45:17 -0600
Message-ID: <05cbdb2a-d561-0691-d5c3-ee787bb6d02e@lechnology.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-18-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-18-git-send-email-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/22/18 5:39 AM, Roger Quadros wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The PRU-ICSS processor bus node and subsystem nodes were left in
> disabled state in the base am33xx.dtsi file. PRU-ICSS is supported
> on these AM335x boards so enable the PRUSS node.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---

This does not apply cleanly to next-20181126. It looks like you
could be missing "ARM: dts: am33xx: convert to use new clkctrl
layout" from your development branch.
