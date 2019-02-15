From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Fri, 15 Feb 2019 14:43:13 +0100
Message-ID: <CAALWOA_7QvtDeNZjXTwbT10MeWJ5wF776mENbX5w1DZHDNVVhA@mail.gmail.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com> <16001a6f-faed-ee14-5ade-79d5462f6d51@ti.com>
 <5C654C39.2030308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5C654C39.2030308@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>, ohad@wizery.com, bjorn.andersson@linaro.org, David Lechner <david@lechnology.com>, nsekhar@ti.com, Tero Kristo <t-kristo@ti.com>, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Robert Nelson <robertcnelson@gmail.com>, dan@kulp.com
List-Id: linux-omap@vger.kernel.org

On Thu, 14 Feb 2019 at 12:08, Roger Quadros <rogerq@ti.com> wrote:
> The beagleboard community is a primary user of this driver and we need to
> find a solution so that PRUSS is usable either via remoteproc or via UIO.

While being able to switch drivers without changing the DT by forcibly
binding a different driver would definitely be a nice feature, and
would have been possible with the older remoteproc-pru bindings, I
think it's a stretch to say this "needs" a solution. Right now, in
practice, selection between uio-pruss and remoteproc-pru is done
simply by modifying the device tree appropriately (typically by having
u-boot apply an overlay to the DT), and I don't think anyone views
this as unduly burdensome?

Matthijs
