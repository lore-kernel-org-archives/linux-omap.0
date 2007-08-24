From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: Omap2430 Rom boot loader NAND EEC scheme?
Date: Thu, 23 Aug 2007 17:01:03 -0700
Message-ID: <a46a26fd0708231701i799be2e0q56f9227d024d54b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

I'm wondering what kind of NAND EEC scheme the Omap2430 rom boot loader
excepts from 2kB NAND chip.

I am trying to make 2430SDP boot from a custom PISMO2 board that has a large
page NAND chip on it. Problem is burning x-loader into this chip so that
on-rom boot loader is able to load it from there. This chip is on supported
list (chip id 0xB1).

If I use u-boot to burn it it will not load as ECCs used by u-boot and rom
boot loader differ. CSST doesn't seem to understand anything beyond the
on-board Samsung NAND so flashing this chip with it seem difficult at best.

For the on-board Samsung NAND CSST seems to use 512/3 byte Hamming ECC
starting from 3rd byte in OOB area. I tried expanding on this by calculating
12 bytes from 2048 bytes of data using the same Hamming ECC and placing them
identically but it did not seem to do the trick.

Cheers,
 - Juha

-- 
Madness takes it's toll. Please have exact change.
