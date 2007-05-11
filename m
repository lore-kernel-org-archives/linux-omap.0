From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: [PATCH] TWL4030 Keypad driver - incorporated review comments
Date: Thu, 10 May 2007 19:04:44 -0500
Message-ID: <782515bb0705101704s3d6d5120s4a5d2785eeeb1b3b@mail.gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47E266A8@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47E266A8@dlee13.ent.ti.com>
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
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

One Tiny comment to save a lot of bytes in git database header file ;):
On 5/10/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> +#define BIT_KEYP_CTRL_REG_SOFTMODEN            (0x001)
> +#define BIT_KEYP_CTRL_REG_SOFTMODEN_M          (0x00000002)
<snip>
> +#define BIT_TIME_OUT_REG1_LSB_TO               (0x000)
> +#define BIT_TIME_OUT_REG1_LSB_TO_M             (0x000000FF)
<snip>
why not have a single bit mask as follows:
#define MASK(OFFSET,NUMBITS) \
                (((0x1<<(NUMBITS))-1)<<(OFFSET))
#define MASK_1BIT(REG) (MASK((REG),1))
Or
#define MASK_1BIT(OFFSET) (0x1<<(OFFSET))

For the fields with more than one bits..
#define BIT_TIME_OUT_REG1_LSB_TO_BITS             (8)
MASK(OFFSET,NUMBITS)
and Just define the offsets.. i'd say that will save some bytes of
header file and bit more readable I think instead of figuring out _M
means a mask... :D Compiler with optimization is be able to get the
consts precompute and put them up as a single val..Here is my
verification process:
CODE:
#define BIT_KEYP_CTRL_REG_SOFTMODEN            (0x001)
#define BIT_KEYP_CTRL_REG_SOFTMODEN_M          (0x00000002)
#define MASK(OFFSET,NUMBITS) \
                (((0x1<<(NUMBITS))-1)<<(OFFSET))
#define MASK_1BIT(OFFSET) (1<<(OFFSET))
/* TIME_OUT_REG1 Fields */
#define BIT_TIME_OUT_REG1_LSB_TO               (0x000)
#define BIT_TIME_OUT_REG1_LSB_TO_M             (0x000000FF)
void some(unsigned int *i)
{
        *i = MASK_1BIT(BIT_KEYP_CTRL_REG_SOFTMODEN);
        //*i = BIT_KEYP_CTRL_REG_SOFTMODEN_M;
        //*i = MASK(BIT_TIME_OUT_REG1_LSB_TO,8);
        //*i = BIT_TIME_OUT_REG1_LSB_TO_M;
}
enable each line and see object file created..
(CodeSourcery ARM Sourcery G++ 2006q3-26) 4.1.1
 arm-none-linux-gnueabi-gcc -O3 -c -Wall -o a.o and
arm-none-linux-gnueabi-objdump -D a.o it looks as follows:
        *i = MASK_1BIT(BIT_KEYP_CTRL_REG_SOFTMODEN);
00000000 <some>:
   0:   e3a03002        mov     r3, #2  ; 0x2
   4:   e5803000        str     r3, [r0]
   8:   e12fff1e        bx      lr
 *i = BIT_KEYP_CTRL_REG_SOFTMODEN_M;
00000000 <some>:
   0:   e3a03002        mov     r3, #2  ; 0x2
   4:   e5803000        str     r3, [r0]
   8:   e12fff1e        bx      lr
*i = MASK(BIT_TIME_OUT_REG1_LSB_TO,8);
00000000 <some>:
   0:   e3a030ff        mov     r3, #255        ; 0xff
   4:   e5803000        str     r3, [r0]
   8:   e12fff1e        bx      lr
*i = BIT_TIME_OUT_REG1_LSB_TO_M;
00000000 <some>:
   0:   e3a030ff        mov     r3, #255        ; 0xff
   4:   e5803000        str     r3, [r0]
   8:   e12fff1e        bx      lr
They all match as to the expected.. so there is my 2 cents... :)
Regards,
Nishanth Menon
