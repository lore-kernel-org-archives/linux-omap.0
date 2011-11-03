From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RESEND] ARM: OMAP: omap_device: Include linux/export.h
Date: Thu, 3 Nov 2011 10:47:35 -0400
Message-ID: <4EB2A987.2040805@windriver.com>
References: <1320303638.17983.5.camel@phoenix> <87d3d9i8ni.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87d3d9i8ni.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Axel Lin <axel.lin@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11-11-03 10:26 AM, Kevin Hilman wrote:
> Axel Lin <axel.lin@gmail.com> writes:
> 
>> Include linux/export.h to fix below build warning:
>>
>>   CC      arch/arm/plat-omap/omap_device.o
>> arch/arm/plat-omap/omap_device.c:1055: warning: data definition has no type or storage class
>> arch/arm/plat-omap/omap_device.c:1055: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
>> arch/arm/plat-omap/omap_device.c:1055: warning: parameter names (without types) in function declaration
>>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> 
> Thanks, will queue as a fix for v3.2-rc

It is probably better if I track this, since export.h won't
exist until Linus pulls the module.h-split tree, and I'm
guessing that will be closer to the end of the merge window.

Thanks,
Paul.

> 
> Kevin
