From: Nikita Kiryanov <nikita@compulab.co.il>
Subject: Re: [PATCH v7 0/6] wlcore: add device-tree support
Date: Tue, 24 Mar 2015 13:37:41 +0200
Message-ID: <55114C85.60703@compulab.co.il>
References: <1426696710-6891-1-git-send-email-eliad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1426696710-6891-1-git-send-email-eliad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eliad Peller <eliad@wizery.com>, linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Rob Herring <robh+dt@kernel.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, Kevin Hilman <khilman@deeprootsystems.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: linux-omap@vger.kernel.org

Hi Eliad,

On 03/18/2015 06:38 PM, Eliad Peller wrote:
> Add device-tree support to the wlcore (wl12xx/wl18xx)
> driver.
>
> Update the current users to use the bindings instead
> of pdata-quirks.
>
> Finally, remove the deprecated wl12xx_platform_data
> struct (along with the da850 board file code that
> still uses it)

Tested-by: Nikita Kiryanov <nikita@compulab.co.il>
Tested on am437x-gp-evm with WL1835MODCOM8B

-- 
Regards,
Nikita Kiryanov
