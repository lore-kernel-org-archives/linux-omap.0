From: "Amit Gupta" <amitjobs05@gmail.com>
Subject: Re: OMAP 2430 SDP
Date: Tue, 29 May 2007 00:25:18 +0530
Message-ID: <78d6ed630705281155o21d47981o1fc8ba938a6f164b@mail.gmail.com>
References: <78d6ed630705270709ied542f9uf40e2df36d874418@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429010F44A3@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429010F44A3@dlee13.ent.ti.com>
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
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Richard

Appreciate your reply.

I got some idea about the boot loader but still things dont seem to be fully
clear.

"You should go thorough the associated design documents you should have
available."

Now i have the reference manual available and it tells about the addresses
and booting of OMAP 2430 SDP but there is no reference of ROM code level
documents in the same. And the boot loader design is based upon the hardware
design of board and OS.

The Linux boot loader xloader and uboot share common code to most extent
that creates the complete confusion about the actual specific need of
Xloader for NAND boooting.

1.As far as I understand X-loader is generic OS independent which is
responsible for hardware initialization( which has not been carried out by
internal ROM code) and transfer the uboot image from flash to SDRAM.


Kindly correct me if I am wrong since I need to generic NAND booting concept
which is not clearly mentioned any where.



2. Now there is again a reference of copy instructions in the start.s. i
understand that it may be redundant but I tried commenting this code and the
image is not booting sucessfully.

But then necessity of this code cannot be justified dince I am assuming that
I am flashing Xloader into NAND Flash and I assume that with NAND settings
my ROM will copy the code into SRAM, then why is it necessary ??

relocate:                /* relocate U-Boot to RAM        */
    adr    r0, _start        /* r0 <- current position of code   */
    ldr    r1, _TEXT_BASE        /* test if we run from flash or RAM */
    cmp r0, r1                  /* don't reloc during debug         */
    /* beq stack_setup */

    ldr    r2, _armboot_start
    ldr    r3, _bss_start
    sub    r2, r3, r2        /* r2 <- size of armboot            */
    add    r2, r0, r2        /* r2 <- source end address         */

copy_loop:
    ldmia    r0!, {r3-r10}        /* copy from source address [r0]    */
    stmia    r1!, {r3-r10}        /* copy to   target address [r1]    */
    cmp    r0, r2            /* until source end addreee [r2]    */
    ble    copy_loop

    /* Set up the stack                            */
stack_setup:
    ldr    r0, _TEXT_BASE        /* upper 128 KiB: relocated uboot   */
    sub    sp, r0, #128        /* leave 32 words for abort-stack    */

clear_bss:
    ldr    r0, _bss_start        /* find start of bss segment        */
    ldr    r1, _bss_end        /* stop here                        */
    mov     r2, #0x00000000        /* clear                            */

//clbss_l:str    r2, [r0]        /* clear loop...                    */
//    add    r0, r0, #4
//    cmp    r0, r1
//    bne    clbss_l

I am not sure whether its possible for you to loook into this code deeply ,
but I am sure you can spare sometime looking into your own code and you
would definitely remember the need for it :)

3 Also can we perform uboot.bin boooting via SDRAM. Why is FLash required if
we can directly port the code into SDRAM and execute it ?

4. Wat is the difference beteween .bin file and .raw file ?What is the OOB
area you referenced in the reply


Thanks a lot in advance

Regards

Aman


On 5/27/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:
>
> > I have been working on NAND booting of OMAP2430 SDP, but I havent been
> > sucessful in the same.
>
> You should go thorough the associated design documents you should have
> available.  The flow is described in the generic OS kernel document,
> other aspects also are in those document sets.  You are likely working
> for someone who has access to this.
>
> Though much more terse, there are rom code level documents which
> describe this in greater detail.
>
> > I have analyzes the X-Loader code available in the group.
> >
> > The files responsible for hardware initialiization are as follows
> >
> > Start.s(Within Folder CPU/arm1136)
> > Platform.s(Within Folder Board/omap2430sdp)
> > omap2430sdp(Within Folder Board/omap2430sdp) - along with header files
> and
> > maybe some other C files where other _init functions are defined.
> >
> > Now in the start.s , there is a mentio of copy section defined as
> > follows:--
> >
> >  /* Copy vectors to mask ROM indirect addr */
> >  adr     r0, _start              /* r0 <- current position of code
> */
> >  add     r0, r0, #4    /* skip reset vector   */
> >  mov     r2, #64                 /* r2 <- size to copy  */
> >  add     r2, r0, r2              /* r2 <- source end address
> */
> >  mov     r1, #0x40000000         /* build vect addr */
> >  mov     r3, #0x00200000
> >  add     r1, r1, r3
> >  mov     r3, #0xf800
> >  add     r1, r1, r3
> > next:
> >  ldmia   r0!, {r3-r10}           /* copy from source address [r0]
> */
> >  stmia   r1!, {r3-r10}           /* copy to   target address [r1]
> */
> >  cmp     r0, r2                  /* until source end address [r2]
> */
> >  bne     next                    /* loop until equal */
> >
> >  bl cpy_clk_code            /* put dpll adjust code behind vectors */
> >
> > Now taking above reference code I  have two doubts:-
> >
> > 1. What is the need of this copy code, when I always know that with
> the
> > NAND
> > settings on my board, the code will be copied from NAND flash into the
> > SRAM
> > area.
> > What is this 64 bytes implies in the line "mov     r2, #64
> /*
> > r2
> > <- size to copy  */ "
> >
> > Is this the size of the total start.s or what
> > Also after this code there is a jump to copy clock code in platform.s
> > where
> > again copy is happening into SRAM. Why is this copy being called again
> and
> > again ??
>
> In the flow used in that code there is some copies which could be
> removed if you compile your execution addresses properly.  I removed
> these when making it work on 3430.
>
> In general you will find exceptions before the MMU is on will be caught
> by the mask rom.  It will re-dispatch this to the SRAM vector address.
>
> > 2. Also what is the location in SRAM at which execution will take
> place ?
> > Is
> > it always default address or we can change that address ?
>
> Depends on the TOC which gets bundled with the image during signing.
>
> > 3. I tried to port the same code xload.bin.ift into NOR(with its
> settings
> > ) and it is executing sucessfully in the sense that it gives banner
> and
> > then
> > hangs ??
> > How is this happening ?
> > Is the execution happeining at XIP incase of NOR or the code copies
> into
> > SRAM for execution
> >
> > 4. In case of NAND flash booting , its giving me bad block error Can
> > anyone
> > tell me the reason for that ?
>
> Maybe you have some bad blocks they are statically present in every
> device.
>
> If you have lots of them, it probably just means in development you
> trashes some of your OOB area.
>
> Hope that helps some.  You should contact your FAE and other support
> mechanisms to get more detailed information.
>
> Regards,
> Richard W.
>
>
