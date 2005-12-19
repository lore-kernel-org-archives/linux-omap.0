From: Olav Kongas <ok@artecdesign.ee>
Subject: RE: omap5912 and regular DDR
Date: Mon, 19 Dec 2005 14:53:22 +0200 (EET)
Message-ID: <Pine.LNX.4.63.0512191302170.2652@pcy.artec.ee>
References: <C51F43ABFC95844490F0529B60753BF402E30EDE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <C51F43ABFC95844490F0529B60753BF402E30EDE@dlee02.ent.ti.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



On Thu, 15 Dec 2005, Hunter, Jon wrote:

> Unfortunately, I do not believe that we support this on the OMAP5912. My
> understanding is that we only support regular SDR, mobile SDR and mobile
> DDR. The description of the EMIFF interface in the data manual only
> lists these. I also recall that we had said no to this in the past to
> from another request. 

Hi Jon, Richard,

Jon, thanks for the information.

We have developed a board on which we use regular DDR 
MT46V16M16TG, attached to omap5912. Last Friday I got the 
DDR working and till now the u-boot's alternative (more 
thorough) memory test has been running flawlessly for about 
72 hours. Though I don't think anyone is stupid enough to 
knowingly design for unsupported memory type, it seems at 
least until now that it can be done with the above memory.

Jon, I would most appreciate if you could find out and 
reveal the reason, why rDDR is not officially supported on 
omap5912. 

Thanks in advance,
Olav
