From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH 3/3] TI814X: Create board support and enable build for
	TI8148 EVM
Date: Thu, 8 Sep 2011 06:51:19 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4AAB78F@dbde02.ent.ti.com>
References: <1312479903-22909-1-git-send-email-hemantp@ti.com>
	<878vqbpxin.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <878vqbpxin.fsf@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hilman, Kevin wrote on Tuesday, August 30, 2011 5:43 AM:

> Hemant Pedanekar <hemantp@ti.com> writes:
> 
>> This patch adds minimal support and build configuration for TI8148 EVM.
>> Also adds support for low level debugging on UART1 console on the EVM.
>> 
>> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
> 
> [...]
> 
>> +static void __init ti8148_init_early(void)
>> +{
>> +	omap2_init_common_infrastructure();
>> +	omap2_init_common_devices(NULL, NULL);
> 
> Note that this function no longer exists in mainline.
> 
> Kevin

Will fix this in v2.

Thanks.
   Hemant
