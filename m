From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: Omap2430 Rom boot loader NAND EEC scheme?
Date: Thu, 23 Aug 2007 19:41:59 -0500
Message-ID: <782515bb0708231741h2f3d1593t8f51dc40afdc6e1a@mail.gmail.com>
References: <a46a26fd0708231701i799be2e0q56f9227d024d54b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <a46a26fd0708231701i799be2e0q56f9227d024d54b6@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Juha,

On 8/23/07, Juha Kuikka <juha.kuikka@gmail.com> wrote:
> I am trying to make 2430SDP boot from a custom PISMO2 board that has a large
> page NAND chip on it. Problem is burning x-loader into this chip so that
> on-rom boot loader is able to load it from there. This chip is on supported
> list (chip id 0xB1).
The Rom code handles ecc in different manner for different page sized
nands. The device you are speaking  most probably is a 1Gbx16 Micron
nand(vendor id=0x2c or so If i recollect right). OOB computation will
not work for romboot. the xloader needs to be downloaded with h/w ecc
in a custom manner. This information, to my knowledge is not public
domain, and I recommend that you speak to TI FAE to get complete
details on the organization.

> If I use u-boot to burn it it will not load as ECCs used by u-boot and rom
> boot loader differ. CSST doesn't seem to understand anything beyond the
> on-board Samsung NAND so flashing this chip with it seem difficult at best.
CSST is designed to download to SDP2430 which is a Samsung 16 bit nand
(i think with vendor id 0xec and device id 0x40), the csst driver does
the romcode specific conversion.

> For the on-board Samsung NAND CSST seems to use 512/3 byte Hamming ECC
> starting from 3rd byte in OOB area. I tried expanding on this by calculating
> 12 bytes from 2048 bytes of data using the same Hamming ECC and placing them
> identically but it did not seem to do the trick.
Having never tried this, well.. no idea.. but the hamming code ecc gen
is slightly different in org with that expected by rom code.

This is just one part of the story. the image even before download
should be signed and then the signed image needs to be stored with
required ecc values(not the x-loader.bin).. How this signing is to be
done is depicted in the csst documentation.

Regards,
Nishanth Menon
