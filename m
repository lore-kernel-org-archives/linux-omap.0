From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: GIT tags
Date: Mon, 22 Oct 2007 18:32:39 +0530
Message-ID: <5d5443650710220602j27abd789idbf1b7600ace50b6@mail.gmail.com>
References: <5D8B5EC1EB6ED845B1EB216F00C71B650206ED60@dlee12.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5D8B5EC1EB6ED845B1EB216F00C71B650206ED60@dlee12.ent.ti.com>
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
To: Iqbal <iqbal@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Iqbal,

On 10/22/07, Iqbal <iqbal@ti.com> wrote:
>
> Hi,
>
> I see that the kernel is advanced from 2.6.23-rc8 to 2.6.23.
> When I do a git-tag -l, at the end I can only see 2.6.23-rc4 and not 2.6.23 or any tags between these two.
>
> So, what I understand is "this list doesn't mess up with the tags", the tags are coming from Linus/kernel.org.
> And, there is no hard fast rule that tags are always updated.

True. You need to do "git fetch tags" for upstream. Looks like Tony
had not fetched tags from kernel.org.

>
> Pl. correct me If I my understanding is wrong.
>
> Also,
>
> How can I get the date when I did the last git-pull/git-fetch?

If you are not messing with your master branch then it will also point
you the latest pulled commit and ofcourse date for that commit.

> If there are any good pointers on versioning please pass it on.
>

If you mean the kernel versioning scheme then there are various
discussion threads and lwn.net articles/presentations might help.


-- 
--Trilok Soni
