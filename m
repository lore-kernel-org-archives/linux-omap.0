From: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 0/3] AM33XX crypto DTS patches
Date: Tue, 08 Oct 2013 17:51:07 +0200
Message-ID: <525429EB.90304@baylibre.com>
References: <1380999877-20884-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380999877-20884-1-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Joel,

n 05/10/2013 21:04, Joel Fernandes wrote:
> These patches are some minor fixups and changes to commit messages to the
> AM33XX crypto (aes, sham) patches with reference to the comments at:
> http://comments.gmane.org/gmane.linux.drivers.devicetree/45961
>
> Joel Fernandes (1):
>    ARM: dts: AM33XX: Fix AES interrupt number
>
> Mark A. Greer (2):
>    ARM: dts: AM33XX: Add SHAM data and documentation
>    ARM: dts: AM33XX: Add AES data and documentation
>
>   .../devicetree/bindings/crypto/omap-aes.txt        | 31 ++++++++++++++++++++++
>   .../devicetree/bindings/crypto/omap-sham.txt       | 28 +++++++++++++++++++
>   arch/arm/boot/dts/am335x-bone.dts                  |  8 ++++++
>   arch/arm/boot/dts/am335x-evm.dts                   |  8 ++++++
>   arch/arm/boot/dts/am335x-evmsk.dts                 |  8 ++++++
>   arch/arm/boot/dts/am33xx.dtsi                      | 19 +++++++++++++
>   6 files changed, 102 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt
>   create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt
>

I've just applied this series and the remaining ones from the previous 
version.

Thanks,
Benoit

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
