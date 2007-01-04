From: Ram <vshrirama@gmail.com>
Subject: u-boot of sdp 2430
Date: Thu, 4 Jan 2007 21:01:12 +0530
Message-ID: <8bf247760701040731t349ef246hc8ebaf2a85fd6248@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
   Im using the u-boot sources located at
   http://linux.omap.com/pub/bootloader/2430sdp/source/

   This is for both Nand and Nor flash, Depending on the configuration in
   include/configs/omap2430sdp.h it will compile it either for NOR/NAND.

  I have enabled the macro CFG_NAND_BOOT in the file for nand boot.

Macros i have enabled are:

#define CFG_ENV_IS_IN_NAND      1
#define CFG_ENV_IS_IN_ONENAND   1
#define CFG_ENV_IS_IN_FLASH     1

#define ENV_IS_VARIABLE 1

If i uncomment any of these, i get linking errors.

Somehow, i could compile u-boot for nand and flash it. right now the
u-boot is aborting in rhe function env_init ( ) ("lib_arm/board.c")

 Im able to flash x-loader and see the messages (output by x-loader).

 Similarly, im able to flash u-boot for nand.

  the x-loader gives control to u-boot.

 howver, im facing someproblem (it aborts) after it enters env_init
(lib_arm/board.c).

 I guess it is unable to take the environment. i couldnt find the
function nand_env_init ( )


Im sure, im missing some macros/giving the wrong macros.

has anyone tried compiling and running u-boot for nand successfully.

I could not understand how environment can be flashed to some location in nand.

What should be the format of that enviroment - How does one generate
the environment file.

I did enable the macro ENV_IS_EMBEDDED.

Im not really sure what im missing.

I appreciate your time.

Regards,
sriram
