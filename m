From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH -next] ARM: dts: am437x: replace linux,wakeup with
 wakeup-source property
Date: Thu, 24 Jan 2019 08:19:39 -0800
Message-ID: <20190124161939.GP5720@atomide.com>
References: <20181221181220.6877-1-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181221181220.6877-1-sudeep.holla@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Sudeep Holla <sudeep.holla@arm.com> [181221 10:12]:
> Most of the legacy "linux,wakeup" boolean property is already replaced
> with "wakeup-source". However few occurrences of old property has popped
> up again, probably from the remnants in downstream trees.
> 
> Replace the legacy properties with the unified "wakeup-source" property
> introduced in the commit aeda5003d0b9 ("Input: matrix_keypad - change
> name of wakeup property to "wakeup-source"")

Sorry for the delays, applying into omap-for-v5.1/dt finally.

Regards,

Tony
