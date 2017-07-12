From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RESEND PATCH] bus: omap-ocp2scp: Fix error handling in
 omap_ocp2scp_probe
Date: Wed, 12 Jul 2017 16:27:34 +0530
Message-ID: <7291e53a-cc06-0056-9f50-50d3c35fba31@ti.com>
References: <20170711101638.2233-1-kishon@ti.com>
 <20170712092616.GC16509@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170712092616.GC16509@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org, "arnd @ arndb . de" <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 12 July 2017 02:56 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [170711 03:17]:
>> The error handling code in omap_ocp2scp_probe fails to invoke
>> pm_runtime_disable and fails to initialize return value in
>> certain cases. Fix it here.
> 
> Applying into omap-for-v4.13/fixes thanks.

Thanks!

-Kishon
