From: Paul Walmsley <paul@pwsan.com>
Subject: Re: 2430 FB driver issues
Date: Sun, 8 Jul 2007 17:01:09 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0707081657410.5848@utopia.booyaka.com>
References: <782515bb0707031706l32231cbbv34a67572068b835f@mail.gmail.com>
	<468E9632.1080205@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <468E9632.1080205@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

On Fri, 6 Jul 2007, Kevin Hilman wrote:

> FWIW, I have the same errors, but have not debugged it further.

You mentioned earlier that this code formerly worked for you before the 
PRCM changes.  Do you have a commit ID or revision from a working version? 
if so then perhaps Nishanth or someone else with a 2430 SDP might be able 
to git-bisect to find which commit broke it.


- Paul
