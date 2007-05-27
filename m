From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP 2430 SDP
Date: Sun, 27 May 2007 10:48:51 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429010F44A3@dlee13.ent.ti.com>
References: <78d6ed630705270709ied542f9uf40e2df36d874418@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <78d6ed630705270709ied542f9uf40e2df36d874418@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Amit Gupta <amitjobs05@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> I have been working on NAND booting of OMAP2430 SDP, but I havent been
> sucessful in the same.

You should go thorough the associated design documents you should have
available.  The flow is described in the generic OS kernel document,
other aspects also are in those document sets.  You are likely working
for someone who has access to this.

Though much more terse, there are rom code level documents which
describe this in greater detail.

> I have analyzes the X-Loader code available in the group.
>=20
> The files responsible for hardware initialiization are as follows
>=20
> Start.s(Within Folder CPU/arm1136)
> Platform.s(Within Folder Board/omap2430sdp)
> omap2430sdp(Within Folder Board/omap2430sdp) - along with header files
and
> maybe some other C files where other _init functions are defined.
>=20
> Now in the start.s , there is a mentio of copy section defined as
> follows:--
>=20
>  /* Copy vectors to mask ROM indirect addr */
>  adr     r0, _start              /* r0 <- current position of code
*/
>  add     r0, r0, #4    /* skip reset vector   */
>  mov     r2, #64                 /* r2 <- size to copy  */
>  add     r2, r0, r2              /* r2 <- source end address
*/
>  mov     r1, #0x40000000         /* build vect addr */
>  mov     r3, #0x00200000
>  add     r1, r1, r3
>  mov     r3, #0xf800
>  add     r1, r1, r3
> next:
>  ldmia   r0!, {r3-r10}           /* copy from source address [r0]
*/
>  stmia   r1!, {r3-r10}           /* copy to   target address [r1]
*/
>  cmp     r0, r2                  /* until source end address [r2]
*/
>  bne     next                    /* loop until equal */
>=20
>  bl cpy_clk_code            /* put dpll adjust code behind vectors */
>=20
> Now taking above reference code I  have two doubts:-
>=20
> 1. What is the need of this copy code, when I always know that with
the
> NAND
> settings on my board, the code will be copied from NAND flash into the
> SRAM
> area.
> What is this 64 bytes implies in the line "mov     r2, #64
/*
> r2
> <- size to copy  */ "
>=20
> Is this the size of the total start.s or what
> Also after this code there is a jump to copy clock code in platform.s
> where
> again copy is happening into SRAM. Why is this copy being called again
and
> again ??

In the flow used in that code there is some copies which could be
removed if you compile your execution addresses properly.  I removed
these when making it work on 3430.

In general you will find exceptions before the MMU is on will be caught
by the mask rom.  It will re-dispatch this to the SRAM vector address.

> 2. Also what is the location in SRAM at which execution will take
place ?
> Is
> it always default address or we can change that address ?

Depends on the TOC which gets bundled with the image during signing.

> 3. I tried to port the same code xload.bin.ift into NOR(with its
settings
> ) and it is executing sucessfully in the sense that it gives banner
and
> then
> hangs ??
> How is this happening ?
> Is the execution happeining at XIP incase of NOR or the code copies
into
> SRAM for execution
>=20
> 4. In case of NAND flash booting , its giving me bad block error Can
> anyone
> tell me the reason for that ?

Maybe you have some bad blocks they are statically present in every
device.

If you have lots of them, it probably just means in development you
trashes some of your OOB area.

Hope that helps some.  You should contact your FAE and other support
mechanisms to get more detailed information.

Regards,
Richard W.
