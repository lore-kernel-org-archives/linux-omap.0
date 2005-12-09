From: Carlos Davila <davila@dfwair.net>
Subject: Re: building XDAIS algorithms
Date: Fri, 09 Dec 2005 10:42:59 -0600
Message-ID: <4399B413.7010402@dfwair.net>
References: <C51F43ABFC95844490F0529B60753BF402CC5CC7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <C51F43ABFC95844490F0529B60753BF402CC5CC7@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hunter, Jon wrote:

>> Is it possible to build the dsp-side 
>>XDAIS algorithm executables using only the Linux DSP Tools or 
>>the montavista tools, without CCS?
>>
>>Thank you,
>>Carlos
>>
>>    
>>
>
>
>This should be possible. However, you will need to create a Makefile for
>the FIR filter project. The *.pjt file that CCS uses is a text file and
>so you can view this with any text editor. In the *.pjt file you will
>see a list of the source files included in the project, plus the
>compiler and linker options used for building the project and creating
>the *.out file. 
>
>  
>
Thanks for your response Jon. The .pjt file also has settings for an 
"Archiver" and a "DspBiosBuilder". I assume the DspBiosBuilder is not 
needed since DspBios is already incorporated into RF6, but the archiver 
appears to be what generates the for_ti.l55l library file used by RF6. 
Can this also be done by gcc?

Carlos
 
