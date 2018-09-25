From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
Date: Tue, 25 Sep 2018 07:40:21 -0700
Message-ID: <20180925144021.GN5662@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <e9afe736-c2f0-6182-afd0-08279e09a35e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <e9afe736-c2f0-6182-afd0-08279e09a35e@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180925 05:18]:
> I tried Branch [1] above. AM335x-boneblack is doing all good with ds0.
> AM437x-gp the following is happening:
> 
> https://pastebin.ubuntu.com/p/fmZNYgJ9Sp/
> 
> There seems to be a timeout due to which resume is not immediate i see
> 1-2s delay and i see i2c timeout.
> 
> [  402.247271] omap_i2c 4802a000.i2c: controller timed out
> [  402.247441] pixcir_ts 1-005c: pixcir_int_enable: can't read reg 0x34
> : -110
> [  402.247486] pixcir_ts 1-005c: Failed to disable interrupt generation:
> -110
> [  402.247522] pixcir_ts 1-005c: Failed to stop
> [  402.247607] dpm_run_callback(): pixcir_i2c_ts_resume+0x0/0x98
> [pixcir_i2c_ts] returns -110
> 
> so pixcir_i2c_ts_resume is retuning -110 which is timeout error code.
> 
> I did some touch screen testing after DS0 resume seems to be working.
> Everything is in pastebin link provided above.

Thanks for testing. Hmm no idea what might be going on with
the pixcir. I have edt-ft5x06 on the am437x-sk-evm and that
behaves just fine for suspend and resume. Both are on i2c1,
pixcir calls pixcir_start/stop from suspend and resume while
edt-ft5x06 does not reconfigure anything.

I'll try read some edt-ft5x06 register values on suspend
and resume, let's see if that makes it reproducable here.

Regards,

Tony
