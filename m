From: Tony Lindgren <tony@atomide.com>
Subject: Re: da850 dt cpufreq support
Date: Wed, 20 Feb 2019 07:46:58 -0800
Message-ID: <20190220154658.GP15711@atomide.com>
References: <ccdb73e4-e4eb-2552-b62f-6cf57929dfee@acn-group.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <ccdb73e4-e4eb-2552-b62f-6cf57929dfee@acn-group.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christophe Aeschlimann <c.aeschlimann@acn-group.ch>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Adding Bartosz, David and Sekhar to Cc.

* Christophe Aeschlimann <c.aeschlimann@acn-group.ch> [190220 15:34]:
> Hi,
> 
> I understand that today the da850-evm is supported in two ways in the
> Kernel, using board file, aka "legacy" and device-tree.
> 
> Am I right to say that when using the device-tree there is no support for
> cpufreq available ?
> 
> The "ti-cpufreq" driver doesn't target the da850 SoC and the
> "davinci-cpufreq" driver doesn't make use of the device-tree bindings.
> 
> Could the generic "cpufreq-dt" driver be used ?
> 
> Best regards,
> 
> Christophe
> 
