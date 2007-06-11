From: Cyrille Chartrain <cyrille.chartrain@purplelabs.com>
Subject: Re: OMAP1710 - Accessing audio codec from arm cpu
Date: Mon, 11 Jun 2007 17:45:05 +0200
Message-ID: <466D6E01.1020402@purplelabs.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I do not know the N80, but if the DSP is used, then your audio codec is 
probably connected to the DSP via the McBSP1, which is in the DSP domain.
Accessing the audio samples via the ARM would be possible if McBSP2 is 
used instead of McBSP1 since McBSP2 is in the ARM domain.
So without a HW modification, I do not see a possibility here.

Regards,

Cyrille
