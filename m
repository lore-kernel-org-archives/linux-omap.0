From: Carlos Davila <davila@dfwair.net>
Subject: building XDAIS algorithms
Date: Thu, 08 Dec 2005 22:47:20 -0600
Message-ID: <43990C58.4060208@dfwair.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello,

I have been adapting the base RF6 application that comes with the TI 
Linux Dsp Tools. The base application implements an FIR filter and a 
volume control. The executable code that implements the XDAIS FIR filter 
algorithm comes in library files located in the rf_3_11_dsp/lib 
directory and appears to have already been built, i.e. the executable 
XDAIS FIR algorithm code is not built when the dsp side RF6 application 
is built, rather, it appears to have been built with code composer 
studio using the project file in rf_3_11_dsp/src/fir_ti/. Is it possible 
to build the dsp-side XDAIS algorithm executables using only the Linux 
DSP Tools or the montavista tools, without CCS?

Thank you,
Carlos
