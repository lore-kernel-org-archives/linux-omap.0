From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/5] net: visually shrink eth_platform_get_mac_address()
Date: Wed, 18 Jul 2018 18:28:49 +0200
Message-ID: <20180718162849.GA12477@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180718161035.7005-2-brgl@bgdev.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Lukas Wunner <lukas@wunner.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, linux-omap@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 18, 2018 at 06:10:31PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Initialize the variables with proper values so that we save a few
> lines of code before we extend this function in the follow-up patches.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  net/ethernet/eth.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index ee28440f57c5..da8530879e1e 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -527,15 +527,10 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>  
>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  {
> -	const unsigned char *addr;
> -	struct device_node *dp;
> +	struct device_node *dp = dev_is_pci(dev) ?
> +			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
> +	const unsigned char *addr = NULL;

Hi Bartosz

You are now in the net subsystem, which has its own set of additional
coding styles. One of them is reverse Christmas tree.

You might want to read Documentation/networking/netdev-FAQ.txt.

    Andrew
