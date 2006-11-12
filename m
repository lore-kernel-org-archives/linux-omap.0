From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: About porting of embedded linux to omap5912
Date: Sun, 12 Nov 2006 22:30:46 +0530
Message-ID: <5d5443650611120900y7744c06an94302ed3779239e4@mail.gmail.com>
References: <1163338703.26963.16.camel@yangchao>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1163338703.26963.16.camel@yangchao>
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
To: yc <superyang1983@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 11/12/06, yc <superyang1983@gmail.com> wrote:
> Hi,everyone. I am a postgraduate student,and I and my fellows are doing
> some research on wireless network with omap5912. We have to port linux
> to the board first. But i don't know which embedded linux is the most
> suitable for omap? My fellows have chosen uclinux,but our version of
> uclinux20051014 seems do not support omap,because it does not contain
> omap in its vendors. Does the newer version of uclinux support omap,or
> is there any better embedded linux? I am a newbie, and I wait for your

You don't need ucLinux there. You can fetch latest linux-omap kernel
from http://source.mvista.com/git and configure for OMAP5912.

Please also visit http://www.muru.com/omap for GIT-OMAP instructions.

--Trilok Soni
