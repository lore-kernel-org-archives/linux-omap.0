From: "rajeev  s" <rajeev2174@rediffmail.com>
Subject: Re :RE: Accessing DSP MMU on OMAP SDP2430
Date: 24 Jan 2007 05:42:27 -0000
Message-ID: <1169480869.S.3614.7806.webmail19.rediffmail.com.old.1169617347.19221@webmail.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: r-woodruff2@ti.com
Cc: linux_omap_open_source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Richard,Since i might not need the address space all the time. I am sticking to doing an ioremap for theAddress space needed.Thanks for the information provided.RegardsRajeev\"Woodruff, Richard\" wroteDepending on when you want to access it and how often you will eitherchose to create a static map for the device or just ioremap it.If you don\'t need to access it much and you don\'t need it a very earlystates of the boot process it is probably just as well to dynamically dohandle it with ioremap.If you are set on static mapping it you can google up an old mail onthis list where I give a lot of information on a thread about internalsram.Regards,Richard W.&gt; -----Original Message-----&gt; From: linux-omap-open-source-bounces@linux.omap.com[mailto:linux-omap-&gt; open-source-bounces@linux.omap.com] On Behalf Of rajeev s&gt; Sent: Monday, January 22, 2007 3:55 AM&gt; To: linux_omap_open_
 source&gt; Subject: Accessing DSP MMU on OMAP SDP2430&gt; &gt; Hi All,I have an sdp2430 b!
 oard (OMAP2430 based).I want to access theDSP&gt; MMU registers from the ARM side .The Address base of this DSP MMURegister&gt; is on the Address range 0x5d000000. To access these registers from ARMto&gt; setup the MMU Translation i added the following code in the&gt; file:include/asm/arch-omap/io.h (Linux source is 2.6-19):#define&gt; IO_VIRT_DSP_L2_RAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xED000000&nbsp; /*va&gt; of&nbsp;DSP MMU&nbsp;*/I arrived at this address using the followinglogic&gt; :0x5d000000&nbsp;+ 0x90000000 = 0xED000000.When i access the DSP MMU&gt; address registers from the Virtual Address base 0xED000000&nbsp;, iget an&gt; kernel crash.Also i have created an entry for this address in the io.c&gt; file as well.Could anybody let me know am i following the correct&gt; procedure.ThanksRajeev&gt; &gt; raj&gt; _______________________________________________&gt; Linux-omap-open-sour
 ce mailing list&gt; Linux-omap-open-source@linux.omap.com&gt; http://linux.omap.com/mailm!
 an/listinfo/linux-omap-open-source
