From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: k3-am6: Introduce pinmux
 definitions
Date: Fri, 9 Nov 2018 03:00:33 -0600
Message-ID: <20181109090033.jx4buin3xuogdgfo@kahuna>
References: <20181108112647.7205-1-vigneshr@ti.com>
 <20181108112647.7205-2-vigneshr@ti.com>
 <20181108134533.3dcy3f53oxze5nlz@kahuna>
 <1c400ca6-9257-0831-6909-fb00b00c4698@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1c400ca6-9257-0831-6909-fb00b00c4698@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vignesh R <vigneshr@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 14:20-20181109, Vignesh R wrote:
> >> +++ b/include/dt-bindings/pinctrl/k3-am6.h
> > 
> > Are we thinking of creating headers for every single SoC?
> 
> We would need one file per SoC family (i.e atleast one for K3 family as
> a whole) as pinctrl register layout is significantly different than

Yes, I am aware of the same.

> other TI SoCs. I can rename the file to include/dt-bindings/pinctrl/k3.h
> to indicate its intended to be common for all K3 SoCs, if you prefer.

Yes, that would be the preference. There are two types of IO muxing IPs
(the equivalent of padconf from omap days) that I
am aware of. However these are all within the same 32bit definitions and
I know there has been significant effort spend by designers based on
software team feedbacks to maintain consistency as much as possible
within technological constraints.

So macros could be used to differentiate within the same header. The
deltas do exist, however they can be differentiated easily.

You should have access to the alternative solution, and even if you
cannot publish it, you should plan the header to scale easily when the
time is appropriate as a trivial additional patch.

For the rest.. Will wait for v2.

-- 
Regards,
Nishanth Menon
