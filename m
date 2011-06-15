From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 3.0-rc2] OMAP: ams-delta: fix broken uevent sysfs entries
Date: Wed, 15 Jun 2011 15:02:58 +0200
Message-ID: <201106151503.04737.jkrzyszt@tis.icnet.pl>
References: <201106070316.41099.jkrzyszt@tis.icnet.pl>
	<20110614115959.GI2353@legolas.emea.dhcp.ti.com>
	<201106151453.07945.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201106151453.07945.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed 15 Jun 2011 at 14:53:01 Janusz Krzysztofik wrote:
> 
> $ grep -r "struct .* platform_device .* = {" .|grep "__initdata"|grep -v '*'
                   ^
                   Without space here, sorry, but result the same.

> ./arch/arm/mach-omap1/board-ams-delta.c:static struct platform_device ams_delta_kp_device __initdata = {
> ./arch/arm/mach-omap1/board-ams-delta.c:static struct platform_device ams_delta_lcd_device __initdata = {
> ./arch/arm/mach-omap1/board-ams-delta.c:static struct platform_device ams_delta_led_device __initdata = {
> ./arch/arm/mach-omap1/board-ams-delta.c:static struct platform_device ams_delta_camera_device __initdata = {
> ./arch/arm/mach-omap1/gpio7xx.c:static struct __initdata platform_device omap7xx_mpu_gpio = {
> ./arch/arm/mach-omap1/gpio7xx.c:static struct __initdata platform_device omap7xx_gpio1 = {
> ./arch/arm/mach-omap1/gpio7xx.c:static struct __initdata platform_device omap7xx_gpio2 = {
> ./arch/arm/mach-omap1/gpio7xx.c:static struct __initdata platform_device omap7xx_gpio3 = {
> ./arch/arm/mach-omap1/gpio7xx.c:static struct __initdata platform_device omap7xx_gpio4 = {
> ./arch/arm/mach-omap1/gpio7xx.c:static struct __initdata platform_device omap7xx_gpio5 = {
> ./arch/arm/mach-omap1/gpio7xx.c:static struct __initdata platform_device omap7xx_gpio6 = {
> ./arch/arm/mach-omap1/gpio15xx.c:static struct __initdata platform_device omap15xx_mpu_gpio = {
> ./arch/arm/mach-omap1/gpio15xx.c:static struct __initdata platform_device omap15xx_gpio = {
> ./arch/arm/mach-omap1/gpio16xx.c:static struct __initdata platform_device omap16xx_mpu_gpio = {
> ./arch/arm/mach-omap1/gpio16xx.c:static struct __initdata platform_device omap16xx_gpio1 = {
> ./arch/arm/mach-omap1/gpio16xx.c:static struct __initdata platform_device omap16xx_gpio2 = {
> ./arch/arm/mach-omap1/gpio16xx.c:static struct __initdata platform_device omap16xx_gpio3 = {
> ./arch/arm/mach-omap1/gpio16xx.c:static struct __initdata platform_device omap16xx_gpio4 = {
> ./arch/arm/mach-omap2/board-rx51-peripherals.c:static struct platform_device rx51_si4713_dev __initdata_or_module = {
