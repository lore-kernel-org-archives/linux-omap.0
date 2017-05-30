From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2] ARM: dts: da850: Add interrupt-controller property to
 gpio node
Date: Tue, 30 May 2017 16:20:11 +0530
Message-ID: <fe594161-3adf-8cd8-df41-63daca1cfeff@ti.com>
References: <1495634501-3246-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1495634501-3246-1-git-send-email-j-keerthy@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>, linus.walleij@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 24 May 2017 07:31 PM, Keerthy wrote:
> The gpio node has 144 gpios. Each gpio is capable of generating
> an interrupt. Hence add interrupt-controller property to the gpio
> node. With this in place one can use interrupts property in device
> tree to request for the gpio interrupts.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Applied to v4.13/dt

Thanks,
Sekhar
