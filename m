From: "Amit Gupta" <amitjobs05@gmail.com>
Subject: OMAP 2430 SDP
Date: Sun, 27 May 2007 19:39:36 +0530
Message-ID: <78d6ed630705270709ied542f9uf40e2df36d874418@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

I have been working on NAND booting of OMAP2430 SDP, but I havent been
sucessful in the same.

I have analyzes the X-Loader code available in the group.

The files responsible for hardware initialiization are as follows

Start.s(Within Folder CPU/arm1136)
Platform.s(Within Folder Board/omap2430sdp)
omap2430sdp(Within Folder Board/omap2430sdp) - along with header files and
maybe some other C files where other _init functions are defined.

Now in the start.s , there is a mentio of copy section defined as follows:--

 /* Copy vectors to mask ROM indirect addr */
 adr     r0, _start              /* r0 <- current position of code   */
 add     r0, r0, #4    /* skip reset vector   */
 mov     r2, #64                 /* r2 <- size to copy  */
 add     r2, r0, r2              /* r2 <- source end address         */
 mov     r1, #0x40000000         /* build vect addr */
 mov     r3, #0x00200000
 add     r1, r1, r3
 mov     r3, #0xf800
 add     r1, r1, r3
next:
 ldmia   r0!, {r3-r10}           /* copy from source address [r0]    */
 stmia   r1!, {r3-r10}           /* copy to   target address [r1]    */
 cmp     r0, r2                  /* until source end address [r2]    */
 bne     next                    /* loop until equal */

 bl cpy_clk_code            /* put dpll adjust code behind vectors */

Now taking above reference code I  have two doubts:-

1. What is the need of this copy code, when I always know that with the NAND
settings on my board, the code will be copied from NAND flash into the SRAM
area.
What is this 64 bytes implies in the line "mov     r2, #64             /* r2
<- size to copy  */ "

Is this the size of the total start.s or what
Also after this code there is a jump to copy clock code in platform.s where
again copy is happening into SRAM. Why is this copy being called again and
again ??

2. Also what is the location in SRAM at which execution will take place ? Is
it always default address or we can change that address ?

3. I tried to port the same code xload.bin.ift into NOR(with its settings
) and it is executing sucessfully in the sense that it gives banner and then
hangs ??
How is this happening ?
Is the execution happeining at XIP incase of NOR or the code copies into
SRAM for execution

4. In case of NAND flash booting , its giving me bad block error Can anyone
tell me the reason for that ?
And also kindly tell me the location where I should port uboot.bin . I
porteed the xloader at default nand flash 0x0C000000. I am confused about if
I port the xload and uboot in flash wont they overwrite in NAND flash ??

Thanks & Regards

Aman
