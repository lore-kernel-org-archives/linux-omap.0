From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP: omap_device: Include linux/export.h
Date: Thu, 03 Nov 2011 07:26:57 -0700
Message-ID: <87d3d9i8ni.fsf@ti.com>
References: <1320303638.17983.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1320303638.17983.5.camel@phoenix> (Axel Lin's message of "Thu,
	03 Nov 2011 15:00:38 +0800")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Axel Lin <axel.lin@gmail.com> writes:

> Include linux/export.h to fix below build warning:
>
>   CC      arch/arm/plat-omap/omap_device.o
> arch/arm/plat-omap/omap_device.c:1055: warning: data definition has no type or storage class
> arch/arm/plat-omap/omap_device.c:1055: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> arch/arm/plat-omap/omap_device.c:1055: warning: parameter names (without types) in function declaration
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Thanks, will queue as a fix for v3.2-rc

Kevin
