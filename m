From: Eduardo Bezerra <edubezval@gmail.com>
Subject: Dealing with DSP Tasks from the kernel space
Date: Wed, 11 Jan 2006 11:22:51 -0400
Message-ID: <a0580c510601110722u5a5aa4bdh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi all,


  I'm tring to load a DSP task from the kernel space. I know that this
stuff is done by a user space utility, dspctl ou dsp_dld. However, I
want to know how to deal (load, communicate, unload, etc) with DSP tasks
from the Kernel Space. There is no much documentation about the code
found in arch/arm/plat-omap/dsp/*. Documentation about DSP Gateway
project comments more user space and "dsp space" related issues.

  Nevertheless, I know that DSP code only exports its symbols if
it is built as a module. When this is done, I can access some importants
objects, such as:

extern unsigned long dspmem_base, dspmem_size,
                     daram_base, daram_size,
                     saram_base, saram_size;
extern struct clk *api_ck_handle;
extern int exmap_valid(void *vadr, size_t len);

  and tranlate dsp adress space into virtual address space with:

#define dspword_to_virt(dw)     ((void *)(dspmem_base + ((dw) << 1)))

  with this, I can write in the dsp memory space by simple:

  if (omap_dsp_request_mem() < 0)
        return -EBUSY;
  clk_use(api_ck_handle);

  memcpy(vadr, buf, written);

  omap_dsp_release_mem();
  clk_unuse(api_ck_handle);

  and, validate any tlb entry with: exmap_valid(vadr, len), if I need
to write in the any shared space.

  I would like to know if the above information is correct and what is
wrong with the steps bellow to load a DSP task:

/*
 * I need to export some symbols from the dsp code to call them here.
 */
        int ret =3D 0;
        long rstvct;

        mpui_byteswap_off();

        /* Do the loading here writing the section using the procedure
           described above */
        rstvct =3D load_dsptask(dspbinary, BINARY_SIZE);

        if (rstvct > 0x00ffffff) {
                printk("Can't determine reset vector "
                                "address: %lx\n", rstvct);
                goto out;
        }

        dsp_cpustat_request(CPUSTAT_RESET);

        ret =3D dsp_set_rstvect(rstvct);
        if (ret < 0)
                goto out;

        dsp_cpustat_request(DSP_RUN);
        ret =3D dspcfg();

   because it hangs up when it "runs" the dsp cpu (dsp_cpustat_request).
It falls into a TLB miss.
   If someone knows where I can find documentation to do this stuff (or
even deal with the DSP into kernel space) I'd appreciate.

BR,


Eduardo Bezerra Valentin
