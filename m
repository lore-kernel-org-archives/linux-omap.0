From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: Linux-omap-open-source Digest, Vol 23, Issue 18
Date: Fri, 10 Mar 2006 01:14:49 -0800 (PST)
Message-ID: <20060310091449.29596.qmail@web32912.mail.mud.yahoo.com>
References: <9343BE359FA4224CA72A94D8CC362C9C09364B@edpc500.cedt.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9343BE359FA4224CA72A94D8CC362C9C09364B@edpc500.cedt.iisc.ernet.in>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in> wrote:

> Dear Mika
> 
> First of all thanks for the reply.
> 
> I am using kernel 2.4.19, with rmk7 patches for omap/kernel, in
> which, I
> think Alsa is not available.  As you guessed correctly I am using
> OSS.
> #cat audio.raw > /dev/dsp also gives me just noise.  Also it looks
> the
> moment I open the dsp device it starts giving noise (In the C program
> I
> mentioned in earlier mail).  I am not sure how to proceed. 
> Suggestions
> are welcome
> 

Don't use that kernel at all. Please switch to,

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=log

where the latest development and bugfixes are being made. To pull the
tree please check the instructions

at http://www.muru.com/linux/omap

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
